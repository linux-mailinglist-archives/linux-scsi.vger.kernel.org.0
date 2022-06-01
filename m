Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB22853A9F0
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jun 2022 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355435AbiFAP0u (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Jun 2022 11:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355408AbiFAP0s (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 Jun 2022 11:26:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE72DE7
        for <linux-scsi@vger.kernel.org>; Wed,  1 Jun 2022 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XH7ph/aHPIGPAz/ZOcFvweC5cM
        r7Jn1O3nxa8RBg8+r8rX48rsUE8q9JMY0AgIiPkKt56EigtdV5D5sQr6UTPplPBs3uXhUGmSDnyZY
        NVG+vEMFvLfYDGKs+ASzhxa0y+IEOkSEp8sV0xHXqFvBgkp/1HaoihWKAKqEcqVo7xfFleF2sU8zb
        fRvT30I8v5zNRmksFkuKASz9NPNJpsBaf03ByBQBub/d15ptvZTTC4GBWg1Lx+rmKyJ2jkZMj5j3x
        vKmlfgHX79QpMyHoV7EV7nphYjKDiu7LH7v2me08oIJuH8yUomZaxBRzDhfJEEU2cO7244iZQy0dJ
        6967NavA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwQFC-00Gsos-Vq; Wed, 01 Jun 2022 15:26:47 +0000
Date:   Wed, 1 Jun 2022 08:26:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Subject: Re: [PATCH v3 2/2] scsi: sd_zbc: prevent zone information memory leak
Message-ID: <YpeFNhJR2lOH/8rb@infradead.org>
References: <20220601062544.905141-1-damien.lemoal@opensource.wdc.com>
 <20220601062544.905141-3-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601062544.905141-3-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

