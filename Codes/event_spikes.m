function spikes = event_spikes(spikes, eventts ,secbefore, secafter)
    spikes = spikes(spikes>=eventts-secbefore & spikes<eventts+secafter);
end