Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9233529952
	for <lists+linux-scsi@lfdr.de>; Tue, 17 May 2022 08:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiEQGLj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 May 2022 02:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiEQGLh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 May 2022 02:11:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CED427D2
        for <linux-scsi@vger.kernel.org>; Mon, 16 May 2022 23:11:36 -0700 (PDT)
Date:   Tue, 17 May 2022 08:11:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652767893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSxgm/7Pd1JJhPeSrjTq/v+c83EZcs+qaKrHmAbM4Z4=;
        b=X9g8U7gU7t5VaYubttC8P3UAKQ0+Mkc9Uf+qrbVrIAcRlEbIwlWZn4Gka4J1yZjXpPevpf
        Na8NeF00Jau/SyslvLc2dQ/8iQvuXfNFBpPWOf4pHwH7cVULicq1Gw7/BtpbRTqwq88I96
        pfPmt7Pu4CeA5fOG6TXciBlDy18neMwXuLyRuBUj6ANUKJ5MtB1iWZrhoXZpRqJeG3ofyD
        WUBzyoGUr0A8ieCJ47g8EWIrhnWEh6M4H5j+PKrYuchIG+uFnyPWN3DCN+jUC8dPnLhiCR
        ksZ5es/ll0MpAycQHf9ZAqWK7hGsyA9heXuv8jhyH6+jjG5NhbF+WclI8PfG7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652767893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSxgm/7Pd1JJhPeSrjTq/v+c83EZcs+qaKrHmAbM4Z4=;
        b=Dzi9TX+RFUmCxNwOxBMwDVWpUARbT0C84AU6Y+RLLgIX7KcIJNZS2F0KYD/73SMP/BRcZE
        X699Zz/4J8fdmtAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@suse.de>,
        Javed Hasan <jhasan@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 0/4] scsi: PREEMPT_RT related fixes.
Message-ID: <YoM8lKljQFcNO4vB@linutronix.de>
References: <20220506105758.283887-1-bigeasy@linutronix.de>
 <yq1mtfhrlrr.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq1mtfhrlrr.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022-05-16 21:28:51 [-0400], Martin K. Petersen wrote:
> 
> Sebastian,
Hi Martin,

> Applied to 5.19/scsi-staging, thanks!

Thank you.

Sebastian
