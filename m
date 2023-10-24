Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F57D43A5
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Oct 2023 02:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjJXAIX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Oct 2023 20:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjJXAIN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Oct 2023 20:08:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD2199A;
        Mon, 23 Oct 2023 17:07:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F83C433C8;
        Tue, 24 Oct 2023 00:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698106073;
        bh=li2R51Mu4XL09/jS2T4UDF6ry6KEeWRQlDptExbPPdo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TKrnsfErRAXx6fdbL9tBG1U5i5BMERb5JaTdkGX3vuEZeLoWv06p9w267vitkfmNO
         WcMZ9gQ5+mslg4jMEbLKlQJlOnPgkaeo1+NeifaC1SLPfxSXJGO8JHS9SGR8AXEUEP
         J1pxzB79FVMUc55GhY9LK/6R7d/1dDfayEvvAVeTMHHalqo0F7Qeys8HBWdB0CdVrx
         F6HuDiBANjWla+Bq1xyDvChI6HqWuFQestNM9eDihEq1mBJfAke5+LEvtgXVDgRCyo
         y+3SKVW3ttgX2zfauPUcKoLi9NPVjyG4AL5i7mv1Af6wmOJvUp0hY+90ulEUc1MWjK
         HUrjB8GW/pTXA==
Message-ID: <bc6856c2-5b06-44dc-ad84-5b43ce94f38f@kernel.org>
Date:   Tue, 24 Oct 2023 09:07:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/19] scsi: Add an argument to scsi_eh_flush_done_q()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        Wenchao Hao <haowenchao2@huawei.com>
References: <20231023215638.3405959-1-bvanassche@acm.org>
 <20231023215638.3405959-6-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231023215638.3405959-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/24/23 06:53, Bart Van Assche wrote:
> This patch prepares for using the host pointer directly in
> scsi_eh_flush_done_q() in a later patch.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

