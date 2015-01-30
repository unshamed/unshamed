/**
 * @jsx React.DOM
 */

var Message = React.createClass({displayName: "Message",
  render: function() {
    return (
      React.createElement("div", null, "MESSAGE")
    );
  }
});

var Section = React.createClass({displayName: "Section",
  render: function() {
    return (
      React.createElement("div", {className: "clearfix msg"}, 
        React.createElement(Message, null)
      )
    );
  }
});

var ConversationList = React.createClass({displayName: "ConversationList",
  render: function() {
    console.log(this.props);
    return (
      React.createElement("li", {className: "clearfix section"}
      )
    );
  }
});


angular.module('unshamed')
  .value('ConversationList', ConversationList);
