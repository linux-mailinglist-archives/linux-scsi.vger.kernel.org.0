Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA4A6474
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2019 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfICI4x (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Sep 2019 04:56:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICI4x (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 Sep 2019 04:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=MQOgOsW4nN0wBR+SsvHSt233F
        aF4q4FssMkGPXMCBa9E7QSaFx5jKu2S8BjRQdcf0HkrUf7eGKmBAlpba3h1abfZTiM2h49uP749Ay
        O1jbETQlWIHmlj/KKl1VG+xx6tac+nfNOtjnTeQTUeNQRcMtbLrJo6B97ZDBInFVo6UaxMpaF3pQO
        72eW5S4N+D9mfyE65zAyiibJ2c8j/vl6MXaLxzFnvS7EBenLBYOaym05ESaeWAtYSR3roxzsDLLDW
        Vq9+O2r8dkpCfmIHnVSfmUyd4E2UtlwwjZKJBOuF0ahTSuRKIQwsvgVcIheYYB5RqkpPZbexAoXQ1
        FFbMBLHJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i54cO-0007lS-MC; Tue, 03 Sep 2019 08:56:52 +0000
Date:   Tue, 3 Sep 2019 01:56:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 3/7] block: Introduce elevator features
Message-ID: <20190903085652.GC23783@infradead.org>
References: <20190828022947.23364-1-damien.lemoal@wdc.com>
 <20190828022947.23364-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828022947.23364-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
