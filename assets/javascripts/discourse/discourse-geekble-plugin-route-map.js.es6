export default function(){
  this.route('discourse-geekble-plugin', function(){
    this.route('hello', {path: '/hello' }, function(){
      this.route('show', {path: '/'});
    });
  });
};