Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1139A1A115F
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Apr 2020 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgDGQaw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Apr 2020 12:30:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQaw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Apr 2020 12:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nuh4nVXCUJwlPsAFN4ZcIX/xOtefRx7Y3gNridK28QY=; b=ciZFBeMvY6ceMxZGa0UjRmpv6b
        Vx/9nAHJ7cxHdVPsGVO0PNZBmYRA2oafiriwUZf2uaLm6sd/JHTHiYn96WGCqPGsDik4kWqPeniyw
        bdPj2+66DNoBS6v1/G5yrPYOsYOcP/bvsesb1lQ1CaETVyn/lrp3nTn0SCkBzpTmooMJ3D/tGkZ+R
        NXpVCbx8OlXunsKpnNLxI2zsDYD8s35fOl9y5pQxPznzzFfQF6aC55FJlcxyBErnqhLDdJdomi9i8
        iGQlKFyYr8/UGVmLCIfv4Z/U8ElXOR0AFlrBMC4KujJgBb0wM24+ct4pshpcOFedveoKb2djkQ37L
        0xZMV4/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLr7R-00017v-Tj; Tue, 07 Apr 2020 16:30:33 +0000
Date:   Tue, 7 Apr 2020 09:30:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        ming.lei@redhat.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        esc.storagedev@microsemi.com, chenxiang66@hisilicon.com,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Message-ID: <20200407163033.GA26568@infradead.org>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
 <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
 <20200311062228.GA13522@infradead.org>
 <b5a63725-722b-8ccd-3867-6db192a248a4@suse.de>
 <9c6ced82-b3f1-9724-b85e-d58827f1a4a4@huawei.com>
 <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Apr 07, 2020 at 04:00:10PM +0200, Hannes Reinecke wrote:
> My concern is this:
> 
> struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
> {
> 	[ .. ]
> 	starget = scsi_alloc_target(&shost->shost_gendev, 0, shost->this_id);
> 	[ .. ]
> 
> and we have typically:
> 
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: .this_id                = -1,
> 
> It's _very_ uncommon to have a negative number as the SCSI target device; in
> fact, it _is_ an unsigned int already.
> 
> But alright, I'll give it a go; let's see what I'll end up with.

But this shouldn't be exposed anywhere.  And I prefer that over having
magic requests/scsi_cmnd that do not have a valid ->device pointer.
