Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915B4CA13C
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Mar 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbiCBJub (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Mar 2022 04:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiCBJu3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Mar 2022 04:50:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338AB91F4
        for <linux-scsi@vger.kernel.org>; Wed,  2 Mar 2022 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yAfzcLb2fcwWQXdis1Vs0Uzn6VPujeyW5qJsqSTgJ+A=; b=nGIrZNzZk18bI3QB3go3HnHceK
        WAmKT84ycO+Qbp7+8OV9FDbrV0NF8uOfPhdkM4Z09p8SzqAWVNqJTO8IHZehJkZhwWime11rDrzJ7
        7NWS8VwIluelHjPHzvUDg9oxSmev0dT9SdMw4iTJii3owilcty3hxKPcCJ66W+vNDmoFLeAVyA0K2
        IPGJ89LYQ/bSDCS4rmXlsZtjf5sly8ykoiDeXC9DYeOxZp1oEzravc20UNvpmR6vH9lAGMS91ZG22
        4rqIwGGC4erJNqb+YL6gUA0cZWkhiwTVVXOtvvgzDee5Wn99wrVc3KFquY62cYYynsoDaZ16W6iUa
        +uz2+NjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPLcA-00281N-PK; Wed, 02 Mar 2022 09:49:46 +0000
Date:   Wed, 2 Mar 2022 01:49:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/14] scsi: core: Pick suitable allocation length in
 scsi_report_opcode()
Message-ID: <Yh89uh0Wuf0kUTcd@infradead.org>
References: <20220302053559.32147-1-martin.petersen@oracle.com>
 <20220302053559.32147-5-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302053559.32147-5-martin.petersen@oracle.com>
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

On Wed, Mar 02, 2022 at 12:35:49AM -0500, Martin K. Petersen wrote:
> Some devices hang when a buffer size larger than expected is passed in
> the ALLOCATION LENGTH field. For REPORT SUPPORTED OPERATION CODES we
> currently only request a single command descriptor at a time and
> therefore the actual size of the command is known ahead of time. Limit
> the ALLOCATION LENGTH to the header size plus the command length of
> the opcode we are asking about.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
