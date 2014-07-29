define('Todo', function(){
  return {
    title : 'Todo', // this will shown as the menu title
    name : 'Todo', // Foundry will add an object with this name, so you can access with it.
    type : 'plugin',
    anchor : '#/Todo', // this property is for angular route
    init : function(){
      // a basic method for foundry to init your plugin
      // we will setup a model here
      var self = this;
      foundry.model('Todo', ['title','completed'], function(model){
        // this callback will return the model being created
        // then you need to make this call to tell foundery 
        // the current plugin is finished loading and ready
        foundry.initialized(self.name);
      });
    },
    inited : function(){ 
       // inited is an optinal method
       // it will be called when all other plugin is loaded
       define_controller();
    }
  } 
});

// maybe some code for angular controller
function define_controller(){
  angular.module('enterprise').controller('TodoController', ['$scope', function($scope){
    $scope.todos = [];
    // get a reference with the model we registered above
    todo_model = enterprise._models.Todo

    $scope.load = function(){
        $scope.todos = todo_model.all()
    }

    $scope.add_todo = function(){
        todo_model.create({title:$scope.todo_title,completed:false});

        $scope.load();
        $scope.todo_title = '';
    }

    $scope.delete_todo = function(index){
        var id = $scope.todods[index].id,
            todo =todo_model.findByAttribute('id', id);

        todo.destroy();
        $scope.load();
    }

    $scope.load();
  }]);
}