Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89D76AA6B4
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Mar 2023 01:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCDAy0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Mar 2023 19:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCDAyY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Mar 2023 19:54:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D614480
        for <linux-scsi@vger.kernel.org>; Fri,  3 Mar 2023 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=qBfTlBVa1tI7RfkL8KPv2YduAwrpv+kJjSMMwzzaB/M=; b=QalvmlNRuy96TOA03ZaJBIWHGv
        YmfxhUUxlNyYvpx+6eBltnpaDAn0pu49CPaSiD4OV16Y8pKGUuyFQLZw9dg1fcFiTnm2Lkj9eM6JY
        Ip0SWHAGmyRhbXU/xvHdzSYBuQ0ZiifoUgIpQOH1TNDzn5yO/syzmfHIvbRtJ5Fun2rD6rvO1bPJi
        WFo+W34MRY7g8XZGh3XxdPHTLmUaqZNkLunbHaw3frapKzgsoYiDM5L1mY0jypKXjiIelcHXYkgo1
        v+3nBrZAnnpRIxOBf7aadj9BxKvu8pKFmYdnJh8CdokCshaG1n7R3WvtGjapsMZrS5BoRxIiVe2RZ
        4wHVF5WQ==;
Received: from 108-90-42-56.lightspeed.sntcca.sbcglobal.net ([108.90.42.56] helo=[192.168.1.80])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pYG9k-00Froq-1s;
        Sat, 04 Mar 2023 00:53:49 +0000
Message-ID: <1a56500e-f92d-93b9-77c7-20186fe43a6d@infradead.org>
Date:   Fri, 3 Mar 2023 16:53:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 65/81] scsi: ps3rom: Declare SCSI host template const
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20230304003103.2572793-1-bvanassche@acm.org>
 <20230304003103.2572793-66-bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <20230304003103.2572793-66-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

On 3/3/23 16:30, Bart Van Assche wrote:
> Make it explicit that the SCSI host template is not modified.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/ps3rom.c | 2 +-

I want to test this.  Please let me know where I can find the whole patch
series, or better, a git repository and branch I can clone.

Thanks.

-Geoff

