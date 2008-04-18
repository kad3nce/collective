/*
===============================================================================
Ruby syntax highlighting support for Chili. This is based on the efforts of 
Dan Webb and Shelly Fisher in the CodeHighlighter JS library. Please see 
http://svn.danwebb.net/external/CodeHighlighter/ for more details.
-------------------------------------------------------------------------------
LICENSE: http://www.opensource.org/licenses/mit-license.php
WEBSITE: http://noteslog.com/chili/
===============================================================================
*/
{
  steps: {
    com     : { exp : /#[^\n]+/ }, 
    string  : { exp : /'[^']*'|"[^"]*"/ }, 
    keyword : { exp : /\b(do|end|self|class|def|if|module|yield|then|else|for|until|unless|while|elsif|case|when|break|retry|redo|rescue|require|raise)\b/ }, 
    sclass  : { exp : /<\s?[A-Z]\w+(::\w+)?/ }, 
    bool    : { exp : /true|false/ }, 
    number  : { exp : /\d+/ }, 
    attr    : { exp : /attr(_accessor|writer|reader)?/ }, 
    symbol  : { exp : /([^:])(:[A-Za-z0-9_!?]+)/ }
  }
}
