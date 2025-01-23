export type CustomMapVisibility = "public" | "private";

export interface CustomMap {
  id: string;
  name: string;
  ownerId: string;
  description?: string;
  center: [number, number];
  visibility: CustomMapVisibility;
  content?: GeoJSON.FeatureCollection;
  createdAt: Date;
  updatedAt?: Date;
}
