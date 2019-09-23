import mongoengine

from models import (
    CommandNewsModel,
    Base,
    QueryNewsModel,
)

from sqlalchemy import Sequence

from nameko.events import EventDispatcher
from nameko.rpc import rpc
from nameko.events import event_handler
from nameko_sqlalchemy import DatabaseSession


# here we establish connection with message broker
class Command:
    # class attributes
    name = 'command_famous'
    dispatch = EventDispatcher()
    db = DatabaseSession(Base)

    @rpc # establish RPC communication model
    def add_news(self, data):
        # all writing commands are executed in the same command
        # because there is no longer 'update' action in Event Sourcing
        try:
            version = 1 # set version in case its a first record with this ID
            if data.get('version'): # if version exists on instance...
                version = (data.get('version') + 1) # ...bump it up
            if data.get('id'): # if instance exist...
                id = data.get('id') # ...get id
            else:
                id = self.db.execute(Sequence('news_id_seq')) # assign id if not exist
            news = CommandNewsModel( # instantiate created/"updated" instance
                id=id,
                version=version,
                title=data['title'],
                content=data['content'],
                author=data['author'],
                published_at=data.get('published_at'),
                tags=data['tags'],
            )
            self.db.add(news) # save record
            self.db.commit()
            # create new event to send info about the above to QueryStack (read DB)
            data['id'] = news.id
            data['version'] = news.version
            self.dispatch('replicate_db_event', data) # generate new event with RPC call 'replicate db event'
            return data
        # if anything goes wrong rollback the previous save to command DB
        except Exception as e:
            self.db.rollback()
            return e


class Query:
    name = 'query_famous'

    @event_handler('command_famous', 'replicate_db_event') # create event to be dispatched when called (in this case called above)
    def normalize_db(self, data):
        try:
            news = QueryNewsModel.objects.get( # if not found, calls DoesNotExist
                id=data['id']
            )
            news.update( # update if found
                version=data.get('version', news.version),
                title=data.get('title', news.title),
                content=data.get('content', news.content),
                author=data.get('author', news.author),
                published_at=data.get('published_at', news.published_at),
                tags=data.get('tags', news.tags),
            )
            news.reload()
        except mongoengine.DoesNotExist:
            QueryNewsModel( # create if not found
                id=data['id'],
                version=data['version'],
                title=data.get('title'),
                content=data.get('content'),
                author=data.get('author'),
                tags=data.get('tags'),
            ).save()
        except Exception as e:
            return e

    @rpc
    def get_news(self, id):
        try:
            news = QueryNewsModel.objects.get(id=id)
            return news.to_json()
        except mongoengine.DoesNotExist as e:
            return e
        except Exception as e:
            return e

    @rpc
    def get_all_news(self, num_page, limit):
        try:
            if not num_page:
                num_page = 1
            offset = (num_page - 1) * limit
            news = QueryNewsModel.objects.skip(offset).limit(limit)
            return news.to_json()
        except Exception as e:
            return e
