package video {
	import org.osflash.signals.Signal;
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	/**
	 * @author acolling
	 */
	public class VideoPlayer extends Sprite {
		private var _videoURL : String;
		private var _connection : NetConnection;
		public var stream : NetStream;
		private var _video : Video;
		public var bufferFlush : Signal;

		public function VideoPlayer(url : String) {
			_videoURL = url;
//			createNetConnection();   triggered later by user so you can set listener for meta data
		}

		public function createNetConnection() : void {
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_connection.connect(null);
		}

		private function netStatusHandler(event : NetStatusEvent) : void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					trace("Stream not found: " + _videoURL);
					break;
				case "NetStream.Buffer.Full":
					bufferFlush.dispatch();
					break;
			}
		}
		
		public function setVideoSize(width:Number, height:Number):void{
			_video.width = width;
			_video.height = height;
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			trace("securityErrorHandler: " + event);
		}

		private function connectStream() : void {
			stream = new NetStream(_connection);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.client = new CustomClient();
			_video = new Video();
			_video.attachNetStream(stream);
			stream.play(_videoURL);
			addChild(_video);
		}
		
		/////			VIDEO CONTROLS

		public function stop() : void {
			stream.pause();
			stream.seek(0);
		}
		
		public function pause():void{
			stream.pause();
		}
		
		public function seek(n:Number):void{
			stream.seek(n);
		}
		
		public function play():void{
//			_video.attachNetStream(stream);  needed?
			stream.play(_videoURL);
		}
		
		public function close():void{
			stream.close();
		}
	}
}







import utils.events.CuePointEvent;
import flash.events.EventDispatcher;

import utils.events.MetaDataEvent;

import flash.events.Event;

// /
class CustomClient extends EventDispatcher {
	public function onMetaData(info : Object) : void {
		//trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		var e : MetaDataEvent = new MetaDataEvent(MetaDataEvent.META_DATA_EVENT, info);
		dispatchEvent(e);
	}

	public function onXMPData(info : Object) : void {
//		trace("XMPDATA"); //USED AS WAS THROWING AN ERROR OTHERWISE for unhandled event
	}

	public function onCuePoint(info : Object) : void {
//		trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
		var e:CuePointEvent = new CuePointEvent(CuePointEvent.CUE_POINT, info.type, info.name, info.time);
		dispatchEvent(e);
	}
}
