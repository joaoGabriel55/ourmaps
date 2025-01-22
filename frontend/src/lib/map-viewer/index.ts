import { MaplibreTerradrawControl } from "@watergis/maplibre-gl-terradraw";

export function createMapBoxDraw() {
  const draw = new MaplibreTerradrawControl({
    modes: [
      "render",
      "point",
      "linestring",
      "polygon",
      "rectangle",
      "circle",
      "freehand",
      "angled-rectangle",
      "sensor",
      "sector",
      "select",
      "delete-selection",
      "delete",
    ],
    open: true,
  });

  return draw;
}

export function onAddFeature(
  draw: MaplibreTerradrawControl,
  callback: (feature: any) => void
) {
  const drawInstance = draw.getTerraDrawInstance();

  if (!drawInstance) return;

  drawInstance.on("finish", (id, context: { action: string; mode: string }) => {
    const snapshot = drawInstance.getSnapshot();

    callback(snapshot);
  });
}

export function onRemoveFeature(
  draw: MaplibreTerradrawControl,
  callback: (features: any) => void
) {
  const drawInstance = draw.getTerraDrawInstance();

  if (!drawInstance) return;

  draw.on("feature-deleted", () => {
    const snapshot = drawInstance.getSnapshot();

    callback(snapshot);
  });
}
