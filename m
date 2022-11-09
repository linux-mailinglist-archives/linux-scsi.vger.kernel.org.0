Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D64622BAF
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Nov 2022 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKIMgo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Nov 2022 07:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKIMgn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Nov 2022 07:36:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46820175B2
        for <linux-scsi@vger.kernel.org>; Wed,  9 Nov 2022 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kUmCcduFIHqaMRYfTlJQwTcQ+aHwuVeIRuqx/cLz+CA=; b=s1vW8pBqKXA9EtkcrQjKWQMKZU
        KrZ0QW7tPLoeJTVtNENtRRGMLeoMYHLLYRvj3NbwJabv3N0CBDtIeBJRrV0PaPBQpXqZgAlwzKod7
        2eZ0HVVAPzhjWAv5fHfAJ4/DW8wZUKTMbu36E+HA0ME+ml6F2QNqkKcHxBkxgk+kM4qdd47oMxeDQ
        m855SP/3WoIa7wQ+y3PqCxd0V2e2cIO7XWFaCKuTfHEm8wI1FQ++Apw/ThrMbt9Y8UDLGwW6dWL5x
        mYzyt942jHxWG+7gChxaUM7ILtvgluOFz4A/2W1FjMiF8hIcjiLTtvqhDCX0U7hjb6nmD+diCsu7F
        2cADJkYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oskJu-00DQQN-SM; Wed, 09 Nov 2022 12:36:42 +0000
Date:   Wed, 9 Nov 2022 04:36:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH 0/2] scsi: sd: use READ/WRITE/SYNC (16) commands per ZBC
Message-ID: <Y2ue2rZzf74/1V+U@infradead.org>
References: <20221109025941.1594612-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109025941.1594612-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

What is the point in relaxing this?  Every modern device better support
16 byte commands even if they aren't strictly required for host aware
devices.
