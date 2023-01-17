Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3A66D5FB
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Jan 2023 07:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjAQGNp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Jan 2023 01:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjAQGNd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Jan 2023 01:13:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54DE2279B;
        Mon, 16 Jan 2023 22:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DbP4hJOIMjacDlikS2S3eYgge6ITrfqjV5pD5iYdtd8=; b=SEBY7iQ3Ls7uffcuVzr/+Gm8iZ
        KGMgFcUaxApeWX4Uh3gVhdvGlhv3ltVt17mv28IC9FeqpinJ7OkhbGVvP33x43WSSmOMBb9tK5B8u
        YAdZDBpWDVUJ7E5C/9v8xN/XibkMN1UvExVvltZakFjtLs4UxiezGCglMb1GEOH24s73BJuOvK45/
        62TW2ouadWOEfyAwZAJ62oJgxTOXjcZfSeELjgEhgkixNgPvTmU75Ud/OjMNcVfm5YSOmWZm5vpE3
        vhhDArmaZIOWdp/SlkC6kHu6LiSNRk0WZ4QN7wY5v3i3wvrmF9/yNRVFUyfgZOaGvSW3fjt05FXjo
        Q+1Vn2kQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHfDt-00D2iC-02; Tue, 17 Jan 2023 06:13:29 +0000
Date:   Mon, 16 Jan 2023 22:13:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 06/18] scsi: support service action in
 scsi_report_opcode()
Message-ID: <Y8Y8iFvxpg+u3GIa@infradead.org>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-7-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112140412.667308-7-niklas.cassel@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Same comment about the extern, otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
