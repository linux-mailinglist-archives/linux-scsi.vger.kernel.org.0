Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82675508EB
	for <lists+linux-scsi@lfdr.de>; Sun, 19 Jun 2022 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiFSG2P (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Jun 2022 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFSG2O (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 19 Jun 2022 02:28:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D47DD12E;
        Sat, 18 Jun 2022 23:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8k//3+aUlOOaHvM9BKNnYZGHMQ1ZaLvSVYrcLmJXm88=; b=M8hcTf2JfW1HZzmSOKJKDJ9j7x
        11EPDM9XUb+dT2ca7SpAmoPS1qb5MVX2I/j8a9g+7vFmcibEn+CcHyrNwP8UdT7uTWo3D0b/T+Pof
        qVnmtKJYUu1jpAXnqB/WjP0mX/qbEuDc8cbsGhBxOYGStpIYBWNFveGJePVXp8+yHoKhFAjyg5Hl9
        lirkAXXdoT7E2J/XivXb2zPnnm4cYrMtr5XOsqE1vbTbgV9Z5aUKxXCX37UontlKJuLlH9PBVoAMN
        wxJZBdsGD31EdS6kKt9WxDXL5AstYds0kHKUz923tYOM6TQ9M15IcCk06ttu/Y027+kOGSlw4TIJC
        e96h6CTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2oPq-00DLlv-Eb; Sun, 19 Jun 2022 06:28:10 +0000
Date:   Sat, 18 Jun 2022 23:28:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 3/4] scsi: target: Fix WRITE_SAME NDOB handling in iblock
Message-ID: <Yq7B+lc523ULJ8cK@infradead.org>
References: <20220617030440.116427-1-michael.christie@oracle.com>
 <20220617030440.116427-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617030440.116427-4-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 16, 2022 at 10:04:38PM -0500, Mike Christie wrote:
> If NDOB is set we don't have a buffer and we will crash when we access
> the t_data_sg. This has us allocate a page to use for the data
> buffer that gets passed to the block layer. For the
> iblock_execute_zero_out case we just add a check for if NDOB was set.

Same as for the file backend applies here.
