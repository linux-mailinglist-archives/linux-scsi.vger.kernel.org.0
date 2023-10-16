Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717107CAA3D
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Oct 2023 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjJPNqo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Oct 2023 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjJPNqb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Oct 2023 09:46:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D6FA
        for <linux-scsi@vger.kernel.org>; Mon, 16 Oct 2023 06:38:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 313E168D1F; Mon, 16 Oct 2023 15:38:57 +0200 (CEST)
Date:   Mon, 16 Oct 2023 15:38:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 12/17] snic: allocate device reset command
Message-ID: <20231016133856.GF28162@lst.de>
References: <20231016092430.55557-1-hare@suse.de> <20231016092430.55557-13-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016092430.55557-13-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 16, 2023 at 11:24:25AM +0200, Hannes Reinecke wrote:
> +	req = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
> +				 BLK_MQ_REQ_NOWAIT);
> +	if (!req) {
> +		SNIC_HOST_ERR(snic->shost,
> +			      "Devrst: TMF busy\n");
> +		goto dev_rst_end;

So if we fail this allocation, which can easily happen, we just fail
the reset and escalate.  If that's fine we probably want a big fat
comment about that here.

