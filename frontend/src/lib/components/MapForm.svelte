<script lang="ts">
  import type { CustomMap } from "../../core/custom-map";

  type Props = {
    map?: CustomMap;
    onSubmit: (formData: FormData) => void;
  };

  let { map, onSubmit }: Props = $props();

  function handleSubmit(event: SubmitEvent) {
    event.preventDefault();

    const form = event.target as HTMLFormElement;
    const formData = new FormData(form);

    onSubmit(formData);

    form.reset();
  }
</script>

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
  <button type="submit" class="btn btn-primary w-full mt-4">Save</button>
</form>
