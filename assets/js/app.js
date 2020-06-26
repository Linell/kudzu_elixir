// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

function addTagToArticle(articleId, tagText, successCallback) {
  console.log('articleId: ', articleId)
  console.log('tagText: ', tagText)
  const csrfToken = $('meta[name=csrf-token]').attr("content")

  $.ajax({
    url: "/articles/" + articleId + "/tag",
    type: "post",
    data: { tag: tagText },
    headers: {
      'X-CSRF-TOKEN': csrfToken
    },
    success: function(data) {
      console.log("SUCCESS: ", data)
      successCallback(data)
    },
    error: function(data) {
      console.log("ERROR: ", data)

      return(false);
    }
  });
}

function updateTagCount(data) {
  // this whole feature is the worst code I've written in years. I love it.
  var existingTag = $(".tagContainer span[data-article-tag='" + data.tag_tag + "']")

  if (existingTag.length > 0) {
    var existingCount = existingTag.find('.tagCount').html()
    var newCount = parseInt(existingCount.match(/\((\d+)\)/)[1]) + 1

    existingTag.find('.tagCount').html("(" + newCount + ")")
  } else {
    var newHTML = "<span class='badge badge-pill badge-primary addTagToArticle' data-article-tag='" + data.tag_tag + "' data-article-id='" + data.tag_id + "'>" 
    newHTML = newHTML + data.tag_tag
    newHTML = newHTML + "<span class='tagCount'>(1)</span>"
    newHTML = newHTML + "</span>"

    $('.tagContainer').append(newHTML)
  }
}

$(".addTagToArticle").click(function(e) {
  const thing     = $(e.target)
  const tagText   = thing.attr('data-article-tag')
  const articleId = thing.attr('data-article-id')

  addTagToArticle(articleId, tagText, updateTagCount);
});

$("#tagSubmitButton").click(function(e) {
  e.preventDefault();
  
  const articleId = $(e.target).attr('data-article-id')
  const tagText   = $("#tagSubmissionForm").val()

  addTagToArticle(articleId, tagText, updateTagCount);
  
  $("#tagSubmissionForm").val('')
});
