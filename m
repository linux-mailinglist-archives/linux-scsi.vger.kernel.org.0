Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583C16CCE28
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Mar 2023 01:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC1Xke (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Mar 2023 19:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC1Xkd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Mar 2023 19:40:33 -0400
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63D1FDB;
        Tue, 28 Mar 2023 16:40:32 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 38FA5E1AAC;
        Tue, 28 Mar 2023 23:40:32 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 23ADF60BEA;
        Tue, 28 Mar 2023 23:40:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id 86VQL90VXSlg; Tue, 28 Mar 2023 23:40:31 +0000 (UTC)
Received: from [192.168.48.17] (host-184-164-23-94.dyn.295.ca [184.164.23.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 7EBD060BE9;
        Tue, 28 Mar 2023 23:40:31 +0000 (UTC)
Message-ID: <9caa24a8-1744-b044-ac7d-782aba05d776@interlog.com>
Date:   Tue, 28 Mar 2023 19:40:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 03/11] scsi: scsi_debug: Change shost list lock to a
 mutex
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
 <20230327074310.1862889-4-john.g.garry@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230327074310.1862889-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2023-03-27 03:43, John Garry wrote:
> The shost list lock, sdebug_host_list_lock, is a spinlock. We would only
> lock in non-atomic context in this driver, so use a mutex instead, which
> is friendlier if we need to schedule when iterating.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com

Thanks.

