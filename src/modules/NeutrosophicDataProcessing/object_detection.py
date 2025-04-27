class YOLOv5ObjectDetector:
    def __init__(self, model_dir="assets", custom_dir="custom-models", model_size="Medium"):
        self.model_dir = model_dir
        self.custom_dir = custom_dir
        self.model_size = model_size
        self.detectors = {}
        self.histogram = {}
        self.num_items_found = 0

    def get_standard_model_path(self):
        """Get path to standard YOLOv5 model based on size"""
        model_map = {
            "large": f"{self.model_dir}/yolov5l.onnx",
            "medium": f"{self.model_dir}/yolov5m.onnx", 
            "small": f"{self.model_dir}/yolov5s.onnx",
            "tiny": f"{self.model_dir}/yolov5n.onnx"
        }
        return model_map.get(self.model_size.lower(), f"{self.model_dir}/yolov5m.onnx")

    def detect_objects(self, image_data, min_confidence=0.4, custom_model=None):
        """Perform object detection on image"""
        model_path = self.get_standard_model_path()
        if custom_model:
            model_path = f"{self.custom_dir}/{custom_model}.onnx"

        # Get or create detector
        detector = self._get_detector(model_path)
        
        # Perform detection
        predictions = detector.predict(image_data, min_confidence)
        
        # Process results
        results = []
        for pred in predictions:
            if pred.score >= min_confidence:
                detected_obj = {
                    "confidence": pred.score,
                    "label": pred.label.name,
                    "x_min": int(pred.rectangle.left),
                    "y_min": int(pred.rectangle.top),
                    "x_max": int(pred.rectangle.right),
                    "y_max": int(pred.rectangle.bottom)
                }
                results.append(detected_obj)
                
                # Update statistics
                self.num_items_found += 1
                label = pred.label.name or "unknown"
                self.histogram[label] = self.histogram.get(label, 0) + 1

        return {
            "count": len(results),
            "predictions": results,
            "inference_device": detector.inference_device,
            "inference_library": detector.inference_library
        }

    def list_custom_models(self):
        """List available custom models"""
        try:
            custom_files = [f for f in os.listdir(self.custom_dir) if f.endswith('.onnx')]
            return [os.path.splitext(f)[0] for f in custom_files]
        except Exception as e:
            return []

    def _get_detector(self, model_path):
        """Get or create detector for given model"""
        if model_path not in self.detectors:
            self.detectors[model_path] = ObjectDetector(model_path)
        return self.detectors[model_path]

    def get_status(self):
        """Get current module status"""
        return {
            "histogram": self.histogram,
            "num_items_found": self.num_items_found
        }