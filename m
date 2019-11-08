Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A401F4063
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2019 07:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHGbi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Nov 2019 01:31:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHGbi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Nov 2019 01:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=SyaFinVAOJGf26GHxQs4vf52O
        4Ebbqe5EGU6buMJU/ipHuaROeUSOqMIj1u3vHEaOb9l3C8PFAUvNfwxsUnWFOgGsKMU+MK8NpFyT3
        k0VzGAtl03S1xxzg+aKjuJKwmdJ0KYvVpAeZ8rvJt7lqk8HNCimkRAOtFtsNiUb766QBs7FjtTpZ5
        LVGfIe+UhXWzWLU6yoIrXmh2I9c//ZjEpdGxqRnTqByj6whLtwsQxcP/UA6Z3zc8GpRqWbXIWB3ZM
        IFvsnspH1kDVIW+nuRPXT5A8y7PyXe+mnAN7fTyN7X2fT9NUmUSrXib3vT9VYp1BIBP2Oy0vKfsBD
        QRd9nkkzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSxo2-0004oZ-5P; Fri, 08 Nov 2019 06:31:38 +0000
Date:   Thu, 7 Nov 2019 22:31:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [dm-devel] [PATCH 8/9] scsi: sd_zbc: Cleanup
 sd_zbc_alloc_report_buffer()
Message-ID: <20191108063138.GC12413@infradead.org>
References: <20191108015702.233102-1-damien.lemoal@wdc.com>
 <20191108015702.233102-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108015702.233102-9-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
