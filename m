Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1FA6481
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2019 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfICI5N (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Sep 2019 04:57:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICI5N (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 Sep 2019 04:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vhIsHUff9nU1D0d7I/0vbBMLDwIosKafjBP+GTnctBE=; b=CozME/+E09j/GSpLys/Hxsim9
        Epi3cTXZ+yYNNzMBCGIHkkrxs9PxurM10jZAlhjq0I350SDEWumTKT7pHxM3XOS7+lWmzJ9YwVuQR
        jPNpX8bnyj3Mbv28ha9dZjGj9eLH6dccolqdaJW5crPxtU0vjJoLv5SJ1f7guIonlnLDvO0I61t17
        233bLzWrRKiAKLZibgVlsTAB5RfLvk6sg8hPIFBowoxrk3HH27gIs1ugGX8jhpDyRZl+iwGg7UHQD
        PcL7FjSGSAN2mCYPsXlTxDoPUb8LJ+nw9wJRFLBk6r6iBcqJ0NQfWH+MtP3TxPUG1Iw0/mT4dIkRE
        YmPStPnlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i54ci-0007nq-OA; Tue, 03 Sep 2019 08:57:12 +0000
Date:   Tue, 3 Sep 2019 01:57:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 4/7] block: Improve default elevator selection
Message-ID: <20190903085712.GD23783@infradead.org>
References: <20190828022947.23364-1-damien.lemoal@wdc.com>
 <20190828022947.23364-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828022947.23364-5-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 28, 2019 at 11:29:44AM +0900, Damien Le Moal wrote:
> For block devices that do not specify required features, preserve the
> current default elevator selection (mq-deadline for single queue
> devices, none for multi-queue devices). However, for devices specifying
> required features (e.g. zoned block devices ELEVATOR_F_ZBD_SEQ_WRITE
> feature), select the first available elevator providing the required
> features.
> 
> In all cases, default to "none" if no elevator is available or if the
> initialization of the default elevator fails.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
