+++
title = "Media"
template = "page.html"
extra = { show_breadcrumbs = false }
+++

<div class="media-grid">

<div class="media-entry">
  <h3 class="media-title">Hashpools - A New Kind of Mining Pool Powered by Ecash</h3>
  <div class="video-thumbnail" onclick="loadVideo(this, 'https://blosstr.com/e11e8de26b4f8ecd2de5ad865d0c91c7adde1c071f48f13ddc9a82505e7f0308.mp4')" style="background-image: url('/images/media/bitcoin-plus-plus-hashpool-thumbnail.jpg'); background-size: cover; background-position: center;">
    <div class="play-button">▶</div>
  </div>
  <p class="media-desc">bitcoin++ ecash edition | Berlin - 2024</p>
</div>

<div class="media-entry">
  <h3 class="media-title">Proxy Pools - Harness the Free Market to Decentralize Bitcoin Mining</h3>
  <div class="video-thumbnail" onclick="loadVideo(this, 'https://blosstr.com/7f60c38d157f8518d8d9d9e72cdc4346da0a055a9f92a1d8fb23a9a5e342f72b.mp4')" style="background-image: url('/images/media/bitcoin-plus-plus-proxy-pool-thumbnail.jpg'); background-size: cover; background-position: center;">
    <div class="play-button">▶</div>
  </div>
  <p class="media-desc">bitcoin++ mempool edition | Austin - 2025</p>
</div>

<div class="media-entry">
  <h3 class="media-title">Hashpools - One Year Development Update</h3>
  <div class="video-thumbnail" onclick="loadVideo(this, 'https://blosstr.com/a9cf0797f6da66efeabe830df864e0094697ab8a8fb3daf41594add494e019ad.mp4')" style="background-image: url('/images/media/btcpp-durham-hashpool-one-year-thumbnail.jpg'); background-size: cover; background-position: center;">
    <div class="play-button">▶</div>
  </div>
  <p class="media-desc">bitcoin++ local edition | Durham, 2025</p>
</div>

<div class="media-entry">
  <h3 class="media-title">eCash & eHash: The Hashpool Solution</h3>
  <div class="video-thumbnail" onclick="loadVideo(this, 'https://blosstr.com/e34bf835cbb362f7173472bed837685820b3e71cb0e72b0b070fe524178681bf.mp4')" style="background-image: url('/images/media/stephan-livera-thumbnail.webp'); background-size: cover; background-position: center;">
    <div class="play-button">▶</div>
  </div>
  <p class="media-desc">Stephan Livera Podcast 681 | August 5, 2025</p>
</div>

</div>

<script>
function loadVideo(thumbnailElement, videoUrl) {
  // Create video element
  const video = document.createElement('video');
  video.className = 'media-video';
  video.controls = true;
  video.preload = 'metadata';
  
  // Create source element
  const source = document.createElement('source');
  source.src = videoUrl;
  source.type = 'video/mp4';
  
  video.appendChild(source);
  
  // Add fallback text
  video.appendChild(document.createTextNode('Your browser does not support the video tag.'));
  
  // Replace thumbnail with video
  thumbnailElement.parentNode.replaceChild(video, thumbnailElement);
  
  // Auto-play the video
  video.play().catch(e => {
    console.log('Auto-play failed:', e);
  });
}
</script>
