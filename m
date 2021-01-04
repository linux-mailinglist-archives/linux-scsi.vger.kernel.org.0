Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381932E9BFB
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Jan 2021 18:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbhADR1j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 12:27:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:34434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbhADR1j (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Jan 2021 12:27:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F5ACAD29;
        Mon,  4 Jan 2021 17:26:58 +0000 (UTC)
Date:   Mon, 4 Jan 2021 18:26:57 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 19/31] elx: efct: Hardware queues creation and deletion
Message-ID: <20210104172657.homt7eloq2pnaj5x@beryllium.lan>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
 <20210103171134.39878-20-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103171134.39878-20-jsmart2021@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi James,

On Sun, Jan 03, 2021 at 09:11:22AM -0800, James Smart wrote:
> +void
> +efct_hw_map_wq_cpu(struct efct_hw *hw)
> +{
> +	struct efct *efct = hw->os;
> +	u32 cpu = 0, i;
> +
> +	/* Init cpu_map array */
> +	for_each_possible_cpu(cpu) {
> +		hw->wq_cpu_array[cpu] = NULL;

This is asking for troubles:

	struct hw_wq		*wq_cpu_array[128];

> +	for (i = 0; i < hw->config.n_eq; i++) {
> +		const struct cpumask *maskp;
> +
> +		/* Get a CPU mask for all CPUs affinitized to this vector */
> +		maskp = pci_irq_get_affinity(efct->pci, i);


Would it not make more sense to ask from the block layer which queue is
mapped to with CPU? blk_mq_map_queues or blk_mq_pci_map_queues? I am
still a bit confused a lot about all these queue/cpu mappings :)

I assuming the code for onlining/offlining CPUs is coming later. Are you
planing to use managed IRQs?

Thanks,
Daniel
