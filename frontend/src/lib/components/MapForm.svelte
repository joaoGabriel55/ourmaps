<script lang="ts">
  import { LockKeyhole } from "lucide-svelte";
  import BackIcon from "lucide-svelte/icons/arrow-left";
  import type { CustomMap } from "$core/custom-map";

  type Props = {
    title: string;
    map?: CustomMap;
    onSubmit: (formData: FormData) => void;
  };

  let { title, map, onSubmit }: Props = $props();

  function handleSubmit(event: SubmitEvent) {
    event.preventDefault();

    const form = event.target as HTMLFormElement;
    const formData = new FormData(form);

    onSubmit(formData);
  }
</script>

<h2 class="card-title">{title}</h2>
<form onsubmit={handleSubmit} class="flex flex-col">
  <label class="form-control w-full max-w-xs">
    <div class="label">
      <span class="label-text">Map name*</span>
    </div>
    <input
      class="input input-bordered w-full max-w-xs"
      type="text"
      name="name"
      placeholder="Cool map name"
      value={map?.name}
      required
    />
  </label>
  <div class="form-control mt-4">
    <label class="label cursor-pointer">
      <div class="flex items-center gap-2">
        <LockKeyhole size={18} />
        <span class="label-text">Private</span>
      </div>
      <input
        class="toggle toggle-primary"
        type="checkbox"
        name="visibility"
        checked={map?.visibility === "private"}
      />
    </label>
  </div>
  <label class="form-control">
    <div class="label">
      <span class="label-text">Description</span>
    </div>
    <textarea
      class="textarea textarea-bordered h-24"
      placeholder="My cool description..."
      name="description"
      value={map?.description}
    ></textarea>
  </label>
  <hr class="my-4" />
  <div class="grid gap-2">
    <button type="submit" class="btn btn-primary w-full">Save</button>
    <a class="btn btn-sm btn-ghost" href="/">Cancel</a>
  </div>
</form>
