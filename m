Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9914C1332
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Feb 2022 13:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbiBWMua (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Feb 2022 07:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiBWMu3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Feb 2022 07:50:29 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00708A88A0
        for <linux-scsi@vger.kernel.org>; Wed, 23 Feb 2022 04:50:01 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D7EF68AA6; Wed, 23 Feb 2022 13:49:56 +0100 (CET)
Date:   Wed, 23 Feb 2022 13:49:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHv2 00/51] SCSI EH argument reshuffle part II
Message-ID: <20220223124956.GA4373@lst.de>
References: <20210817091456.73342-1-hare@suse.de> <20210817121307.GA30436@lst.de> <1b9ad85c-407d-0877-964c-5f685d8cc702@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b9ad85c-407d-0877-964c-5f685d8cc702@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Aug 17, 2021 at 02:55:25PM +0200, Hannes Reinecke wrote:
> On 8/17/21 2:13 PM, Christoph Hellwig wrote:
> > First, thanks for resurrecting the series.
> > 
> > Second, this giant patchbomb is almost impossible to review.  It might
> > make sense to resend what is the prep patches without the prototype
> > changes after the first round of review - maybe we can squeeze those
> > into 5.15 still and do the heavy lifting with another series per
> > actually changes method or so.
> > 
> Sure, can do.

Do you have another chunk of these patches ready?  It would be so nice
to see the EH code finally cleaned up..
