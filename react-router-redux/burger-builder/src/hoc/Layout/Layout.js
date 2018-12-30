import React, { Component } from 'react'

import Aux from '../Aux/Aux'
import classes from './Layout.css'
import Toolbar from '../../components/Navigation/Toolbar/Toolbar'
import SideDrawer from '../../components/Navigation/SideDrawer/SideDrawer'
import { connect } from 'react-redux';

class Layout extends Component {
	state = {
		showSideDrawer: false
	}

	sideDrawerClosedHandler = () => {
		this.setState({ showSideDrawer: false  });
	}

	sideDrawerOpenHandler = () => {
		this.setState({ showSideDrawer: true });
	}

	sideDrawerToggleHandler = () => {
		// this.setState({ showSideDrawer: !this.state.showSideDrawer  }); //Due to async nature of setstate, this may lead to unexpected outcome
		this.setState((prevState) =>  {
			return { showSideDrawer: !prevState.showSideDrawer }
		})
		// this.setState
	}
	
	render() {
		return (
			<Aux>
				<Toolbar
					isAuth={this.props.isAuthenticated}
					drawerToggleClicked={this.sideDrawerToggleHandler} />
				<SideDrawer
					isAuth={this.props.isAuthenticated}
					open={this.state.showSideDrawer}
					closed={this.sideDrawerClosedHandler}/>
				<main className={classes.Content}>
					{this.props.children}
				</main>
			</Aux>
		)
	}
}

const mapStateToProps = state => {
	return {
		isAuthenticated: state.auth.token !== null
	}
}

export default connect(mapStateToProps)( Layout )
