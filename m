Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE4A7BF2
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Sep 2019 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfIDGrR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Sep 2019 02:47:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfIDGrR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Sep 2019 02:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4CfBjJKF068cPJtXwRGO46BkBc5jRBangcaiofET358=; b=HeBw0PKMxSSUDF1vPFb91ZmWq
        zgC4LTQ+WFsmbBFO0V87OBx8UcJAPPhytsgxA7WWAkxoqbZR0oNXU44KXxGz/NZwZNQPhsugC5zSK
        Px8yrzj1hZojjA0lgZZCOxbD3LUhH6p+Ikx8LS7urj0t61oCM9Nok33FYg8E7aXVeXA2XXdjXfe2f
        maYv07v1TdeQIFyN2ADymFOf7oFcOKFsmWwI000ls1sJ2hSPUSxZ2U3/gvL4zAIzAoCigRvIrHm6O
        D5uQeVqMpA+/yom4NZ5wPY/dbrSEktfwNrAhg7fg8icP4z0P0NYiOncbTD65ckbOkRi1wkFJnHeDp
        9g/Mu1fXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5P4W-0004aK-D8; Wed, 04 Sep 2019 06:47:16 +0000
Date:   Tue, 3 Sep 2019 23:47:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 5/7] block: Delay default elevator initialization
Message-ID: <20190904064716.GA17496@infradead.org>
References: <20190828022947.23364-1-damien.lemoal@wdc.com>
 <20190828022947.23364-6-damien.lemoal@wdc.com>
 <20190903090247.GE23783@infradead.org>
 <BN8PR04MB581263CA0FBCED3394722EF9E7B80@BN8PR04MB5812.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR04MB581263CA0FBCED3394722EF9E7B80@BN8PR04MB5812.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Sep 04, 2019 at 02:07:39AM +0000, Damien Le Moal wrote:
> OK. I will move the registration earlier in device_add_disk(), before the region
> registration.
> 
> However, I would still like to keep the queue freeze to protect against buggy
> device drivers that call device_add_disk() with internal commands still going
> on. I do not think that there are any such driver, but just want to avoid
> problems. The queue freeze is also present for any user initiated elevator
> change, so in this respect, this is not any different and should not be a big
> problem. Thoughts ?

I don't really see the point, but there should be no harm it either
since a freeze of a non-busy queue should be fast.
