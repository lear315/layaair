package laya.debug.tools
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.resource.Texture;
	import laya.utils.Browser;
	
	/**
	 * 本类用于操作html对象
	 * @author ww
	 */
	public class JSTools
	{
		
		public function JSTools()
		{
		
		}
		
		/**
		 * 将html对象添加到body上
		 * @param el
		 * @param x
		 * @param y
		 *
		 */
		public static function showToBody(el:Object, x:Number = 0, y:Number = 0):void
		{
			Browser.document.body.appendChild(el);
			var style:Object;
			
			style = el.style;
			style.position = "absolute";
			style.top = y + "px";
			style.left = x + "px";
		}
		
		/**
		 * 将html对象添加到显示列表上的某个对象的上方
		 * @param el
		 * @param sprite
		 * @param dx
		 * @param dy
		 *
		 */
		public static function showAboveSprite(el:Object, sprite:Sprite, dx:Number = 0, dy:Number = 0):void
		{
			var pos:Point;
			pos = new Point();
			pos = sprite.localToGlobal(pos);
			pos.x += dx;
			pos.y += dy;
			pos.x += Laya.stage.offset.x;
			pos.y += Laya.stage.offset.y;
			showToBody(el, pos.x, pos.y);
		}
		
		/**
		 * 移除html对象
		 * @param el
		 *
		 */
		public static function removeElement(el:Object):void
		{
			Browser.removeElement(el);
		}
		
		public static function getImageSpriteByFile(file:Object,width:Number=0,height:Number=0):Sprite
		{
			var reader:Object;
			__JS__("reader= new FileReader();");
			reader.readAsDataURL(file);
			var sprite:Sprite;
			sprite = new Sprite();
			reader.onload = function(e)
			{
				var txt:Texture;
				txt = new Texture();
				txt.load(this.result);
				sprite.graphics.drawTexture(txt, 0, 0,width,height);
			}
			return sprite;
		}
		
		private static var _pixelRatio:Number=-1;
		public static function getPixelRatio():Number
		{
			if (_pixelRatio > 0) return _pixelRatio;
			var canvas:* = Browser.createElement("canvas");
			var context:* = canvas.getContext('2d');
			 var devicePixelRatio:Number = Browser.window.devicePixelRatio || 1;
             var  backingStoreRatio:Number = context.webkitBackingStorePixelRatio ||
                            context.mozBackingStorePixelRatio ||
                            context.msBackingStorePixelRatio ||
                            context.oBackingStorePixelRatio ||
                            context.backingStorePixelRatio || 1;

              var ratio:Number = devicePixelRatio / backingStoreRatio;
			  trace("pixelRatioc:", ratio);
			  _pixelRatio = ratio;
			  return ratio;
		}

	}

}