Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819394CA195
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Mar 2022 10:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiCBJ7r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Mar 2022 04:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbiCBJ7h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Mar 2022 04:59:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1EB31932
        for <linux-scsi@vger.kernel.org>; Wed,  2 Mar 2022 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=uJuJer/LqSbqx/Qe5G03ZScc38
        sBwzp1z0ETbh3qSdLCr9iQxWgYkpEp259+DKnERixTpxsj3A6GZxG24y6zdI4HavPcM7eCC+2RerF
        mvE8PFWD/KOs2GVf7xD9rrhwTQK6AeMzFzZI1sQ4QOoZm+5i2TXi+g0JvA+1px5g2Xuv0sil9aGhT
        l4VuuMoKkSpvkZzj026BWv+QhdHHVKj2hvKXUr9TCBKehDQO9yT9eUU22NCOVqJJ4+yWP5CjXGTgo
        Rf5lKN0TTp30RyXH7DGIStU621k5dea5RmlZtpvk03vayqapJ15fOlU/C3zKPeJqK7nM8Yad02xQe
        +UNtYe6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPLkd-002BOZ-U4; Wed, 02 Mar 2022 09:58:31 +0000
Date:   Wed, 2 Mar 2022 01:58:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Aman Karmani <aman@tmm1.net>,
        David Sebek <dasebek@gmail.com>
Subject: Re: [PATCH 14/14] scsi: sd: Enable modern protocol features on more
 devices
Message-ID: <Yh8/x0uWz7Fjlltw@infradead.org>
References: <20220302053559.32147-1-martin.petersen@oracle.com>
 <20220302053559.32147-15-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302053559.32147-15-martin.petersen@oracle.com>
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
