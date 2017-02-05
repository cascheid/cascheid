angular.module('indexApp').controller('aboutCtrl', [function(){
	var ctrl = this;
	
	ctrl.javaExperience = {percent: 80, desc: 'Advanced'};
	ctrl.jsExperience = {percent: 85, desc: 'Advanced'};
	ctrl.sqlExperience = {percent: 65, desc: 'Proficient'};
	ctrl.unixExperience = {percent: 45, desc: 'Proficient'};
	ctrl.cssExperience = {percent: 69, desc: 'Proficient'};
	ctrl.toolsExperience = {percent: 50, desc: 'Proficient'};
}]);