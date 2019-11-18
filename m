Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA171006E2
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKRN5w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 08:57:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:47932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbfKRN5w (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 08:57:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1C36B199;
        Mon, 18 Nov 2019 13:57:50 +0000 (UTC)
Date:   Mon, 18 Nov 2019 14:57:49 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] lpfc: fixup out-of-bounds access during CPU hotplug
Message-ID: <20191118135749.memhmfxzv4ailubv@beryllium.lan>
References: <20191118123012.99664-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118123012.99664-1-hare@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Hannes,

On Mon, Nov 18, 2019 at 01:30:12PM +0100, Hannes Reinecke wrote:
> The lpfc driver allocates a cpu_map based on the number of possible
> cpus during startup. If a CPU hotplug occurs the number of CPUs
> might change, causing an out-of-bounds access when trying to lookup
> the hardware index for a given CPU.
> 
> Suggested-by: Daniel Wagner <daniel.wagner@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

There are a few more places I think the check is needed:

lpfc_nvme_fcp_io_submit(), lpfc_nvmet_ctxbuf_post(),
lpfc_nvmet_xmt_fcp_op(), lpfc_nvmet_rcv_unsol_abort(),
lpfc_nvme_io_cmd_wqe_cmpl(), lpfc_nvmet_unsol_fcp_buffer(),
lpfc_scsi_cmd_iocb_cmpl()

At least all of them seem to use the CPU id to access some array. I
suggest we review all those places as well.

Thanks,
Daniel
