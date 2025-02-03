import type { User } from "./user";

export type CustomMapVisibility = "public" | "private";

export interface CustomMap {
  id: string;
  name: string;
  owner: User;
  description?: string;
  center: [number, number];
  visibility: CustomMapVisibility;
  content?: GeoJSON.FeatureCollection;
  collaborators?: Array<User>;
  createdAt: Date;
  updatedAt?: Date;
}
