Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3439858FC0B
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Aug 2022 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiHKMRD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Aug 2022 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHKMRC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Aug 2022 08:17:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5538FD5D
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 05:17:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B239968AA6; Thu, 11 Aug 2022 14:16:58 +0200 (CEST)
Date:   Thu, 11 Aug 2022 14:16:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, mwilck@suse.com, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH 1/4] scsi: Fix passthrough retry counter handling
Message-ID: <20220811121658.GA1742@lst.de>
References: <20220810034155.20744-1-michael.christie@oracle.com> <20220810034155.20744-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810034155.20744-2-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Aug 09, 2022 at 10:41:52PM -0500, Mike Christie wrote:
>  	scsi_init_command(sdev, cmd);
>  
> +	if (!blk_rq_is_passthrough(req))
> +		cmd->allowed = 0;
> +
>  	cmd->eh_eflags = 0;
> -	cmd->allowed = 0;

While this is correct, I think it makes the function read rather odd.

I'd move it down after the:

	if (blk_rq_is_passthrough(req))
		return scsi_setup_scsi_cmnd(sdev, req);

and maybe add a comment;

	/* usually overriden by the ULP */
	cmd->allowed = 0;

