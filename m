Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4F518643
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiECORE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 May 2022 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiECORD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 May 2022 10:17:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183881705C
        for <linux-scsi@vger.kernel.org>; Tue,  3 May 2022 07:13:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C3FB68D0F; Tue,  3 May 2022 16:13:28 +0200 (CEST)
Date:   Tue, 3 May 2022 16:13:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 14/24] aic79xx: make BUILD_SCSIID() a function
Message-ID: <20220503141327.GN22590@lst.de>
References: <20220502213820.3187-1-hare@suse.de> <20220502213820.3187-15-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502213820.3187-15-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, May 02, 2022 at 11:38:10PM +0200, Hannes Reinecke wrote:
> +{
> +	unsigned int scsiid =
> +		((sdev_id(sdev) << TID_SHIFT) & TID) | (ahd)->our_id;
> +
> +	return scsiid;

	return ((sdev_id(sdev) << TID_SHIFT) & TID) | ahd->our_id;
