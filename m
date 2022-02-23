Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86084C1392
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Feb 2022 14:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiBWNGa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Feb 2022 08:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbiBWNG0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Feb 2022 08:06:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F896817
        for <linux-scsi@vger.kernel.org>; Wed, 23 Feb 2022 05:05:58 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A853868AA6; Wed, 23 Feb 2022 14:05:54 +0100 (CET)
Date:   Wed, 23 Feb 2022 14:05:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHv2 00/51] SCSI EH argument reshuffle part II
Message-ID: <20220223130554.GB4489@lst.de>
References: <20210817091456.73342-1-hare@suse.de> <20210817121307.GA30436@lst.de> <1b9ad85c-407d-0877-964c-5f685d8cc702@suse.de> <20220223124956.GA4373@lst.de> <8cb8268e-d058-cc75-423b-969631496d75@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cb8268e-d058-cc75-423b-969631496d75@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 23, 2022 at 02:03:01PM +0100, Hannes Reinecke wrote:
> Sure. Against which tree?
> The SCSI pointer and scsi_request removal will have an impact onto these 
> patches I guess, so I'd rather code against those patches folded in.

The SCSI pointer removal already is in Martin's staging tree, so that
is a good baseline.  I don't think the the scsi_request removal should
have much overlap with the various driver patches and just a trivial
overlap with the scsi_ioctl_reset changes.

So maybe just prepare a first batch that is needed for the eh_host_reset
prototype changes against Martin's staging tree?
