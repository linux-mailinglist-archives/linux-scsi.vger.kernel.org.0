Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD44CA14A
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Mar 2022 10:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbiCBJvO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Mar 2022 04:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbiCBJvL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Mar 2022 04:51:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF2E09C
        for <linux-scsi@vger.kernel.org>; Wed,  2 Mar 2022 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=yOJsLrS1VMbPKAMWajsvZnATfi
        Q6HV98fpfFnSvKEv0/tN2gWKUs83gjdqHU0jd+SYWmxHudaAPf68kXJad4IvnoO9vYPqMoaXvuo6s
        9/1LdBTGFF6vf8w63cbrcc7GWS2LR1vLz2n4jD9vqscw2sKfPPkI5nb4xPgEEhqQdDlWilg0LCJAB
        +zVnPlEhNBW9BYegBC30+P2kuzDU+IS7XcbVhYZHEwMHa06NC6itcL+2YimFDdxoGGGPEk0Ze2VUI
        rYXuIkSN/8rG/BvCANFHMDGBzWLtPyhnljcwFC73D2Vzji1bGmZJa0H1e/CXDg/7fsPKw+jpqe+5V
        +KxDOZoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPLcq-0028Lc-EY; Wed, 02 Mar 2022 09:50:28 +0000
Date:   Wed, 2 Mar 2022 01:50:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 06/14] scsi: sd: Use cached ATA Information VPD page
Message-ID: <Yh895KQbOAEAsDcp@infradead.org>
References: <20220302053559.32147-1-martin.petersen@oracle.com>
 <20220302053559.32147-7-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302053559.32147-7-martin.petersen@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
