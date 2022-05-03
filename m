Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9C518640
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiECOQa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 May 2022 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiECOQ0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 May 2022 10:16:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80E117E0E
        for <linux-scsi@vger.kernel.org>; Tue,  3 May 2022 07:12:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 196E668D0A; Tue,  3 May 2022 16:12:50 +0200 (CEST)
Date:   Tue, 3 May 2022 16:12:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 13/24] aic7xxx: make BUILD_SCSIID() a function
Message-ID: <20220503141249.GM22590@lst.de>
References: <20220502213820.3187-1-hare@suse.de> <20220502213820.3187-14-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502213820.3187-14-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +{
> +	unsigned int scsiid =
> +		((sdev->id << TID_SHIFT) & TID) |
> +		((sdev->channel == 0) ? ahc->our_id : ahc->our_id_b) |
> +		(sdev->channel == 0) ? 0 : TWIN_CHNLB;
> +	return scsiid;

This still look weird.  Why not:

	unsigned int scsiid = (sdev->id << TID_SHIFT) & TID);

	if (sdev->channel == 0) {
		scsiid |= ahc->our_id;
	else
		scsiid |= ahc->our_id_b | TWIN_CHNLB;
	return scsiid;

?
