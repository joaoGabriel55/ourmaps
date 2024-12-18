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

  drawInstance?.on("finish", (id) => {
    const snapshot = drawInstance.getSnapshot();
    const feature = snapshot?.find((f) => f.id === id);

    if (feature) callback(feature);
  });
}
