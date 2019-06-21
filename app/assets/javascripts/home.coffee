# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

toggleBookmarkIcon = (icon) ->
	icon.classList.toggle('fas')
	icon.classList.toggle('far')

for element in document.getElementsByClassName('fa-bookmark')
	console.log element
	element.addEventListener 'click', element.classList.toggle('fas')
	element.addEventListener 'click', element.classList.toggle('far')  