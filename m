Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9CE2AD0
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Oct 2019 09:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437883AbfJXHKc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Oct 2019 03:10:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437880AbfJXHKc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Oct 2019 03:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TlX/j13JyJ40RtfyL0ytnVIfx
        x11gOEmVXpR/0V6vLkadvaPuBzk0vJSH+dZf90gzkQR3tr+eIskkLNnqjYemZczIC6I89Yvq6P0Mq
        S1HnAqunqvOVUQqD8GT8QQeZgGcHtkdpbUB8k6KuPZwcrBqLVdQ3dDysaJKTycZfKGfQmpKjH5/XM
        jW+rGbW2RmovI/8T2crFCsfCSX7CCAFt7h4zYk6oo/B9tC9ZKA7LtImQ7DOQDaIg4hRfXQZ75XV/9
        UjnJWK92Rn/15XGSAi24GV6ModX7JNANhiOWLdtWw25vRSRTrVZbuPq8LuWypBpc3XQvEagEE4R0r
        kLsGA59Hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNXGS-0001HL-8J; Thu, 24 Oct 2019 07:10:32 +0000
Date:   Thu, 24 Oct 2019 00:10:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/4] block: Simplify report zones execution
Message-ID: <20191024071032.GB19572@infradead.org>
References: <20191024065006.8684-1-damien.lemoal@wdc.com>
 <20191024065006.8684-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024065006.8684-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
