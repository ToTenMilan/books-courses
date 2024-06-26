import React, { useRef } from 'react';
import cs from './styles';
import { Query, Mutation } from "react-apollo";
import { Me, SignMeIn } from "./operations.graphql"

const UserInfo = () => {
  const input = useRef(null);

  return (
    <div className={cs.panel}>
      <Query query={Me}>
        {({ data, loading }) => {
          if (loading) return "...Loading";
          if (!data.me) {
            // show login form
            return (
              <Mutation
              mutation={SignMeIn}
              update={(cache, { data: { signIn } }) => {
                cache.writeQuery({
                  query: Me,
                  data: { me: signIn.user },
                });
              }}  
            >
              {
                (signIn, { loading: authenticating, error }) =>
                authenticating ? (
                  "..."
                ) : (
                  <div className={cs.signIn}>
                    <form
                    // missing div???
                      onSubmit={event => {
                        event.preventDefault();
                        signIn({
                          variables: { email: input.current.value }
                        }).then(({ data: { signIn: { token } } }) => {
                          if (token) {
                            localStorage.setItem('mlToken', token);
                          }
                        })
                      }}
                    >
                      <input
                        ref={input}
                        type="email"
                        className={cs.input}
                        placeholder="your email"
                      />
                      <input
                        type="submit"
                        className={cs.button}
                        value="Sign In"
                      />
                      {error && <span>{error.message}</span>}
                    </form>
                  </div>
                )
              }
            </Mutation>
            )
          }

          const { fullName } = data.me;
          return <div className={cs.info}>😈  {fullName}</div>
        }}
      </Query>
    </div>
  )
}

export default UserInfo