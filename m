Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F271543AF0
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jun 2022 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiFHR6l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Jun 2022 13:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiFHR6h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Jun 2022 13:58:37 -0400
X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 10:58:36 PDT
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD7A14FCB6
        for <linux-scsi@vger.kernel.org>; Wed,  8 Jun 2022 10:58:36 -0700 (PDT)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 162BEE0E88;
        Wed,  8 Jun 2022 17:52:37 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id 0F9674FE2F;
        Wed,  8 Jun 2022 17:52:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id 8hkYqcO5Kh3t; Wed,  8 Jun 2022 17:52:36 +0000 (UTC)
Received: from [10.16.26.45] (unknown [62.97.234.74])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id D8EC04AD78;
        Wed,  8 Jun 2022 17:52:35 +0000 (UTC)
Message-ID: <01ac6434-3b06-5e9d-3036-660785752741@interlog.com>
Date:   Wed, 8 Jun 2022 19:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v2] scsi: scsi_debug: fix zone transition to full
 condition
Content-Language: en-CA
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220608011302.92061-1-damien.lemoal@opensource.wdc.com>
 <YqAA5ywNC4kdRWXz@x1-carbon>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <YqAA5ywNC4kdRWXz@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022-06-08 03:52, Niklas Cassel wrote:
> On Wed, Jun 08, 2022 at 10:13:02AM +0900, Damien Le Moal wrote:
>> When a write command to a sequential write required or sequential write
>> preferred zone result in the zone write pointer reaching the end of the
>> zone, the zone condition must be set to full AND the number of
>> implicitly or explicitly open zones updated to have a correct accounting
>> for zone resources. However, the function zbc_inc_wp() only sets the
>> zone condition to full without updating the open zone counters,
>> resulting in a zone state machine breakage.
>>
>> Introduce the helper function zbc_set_zone_full() and use it in
>> zbc_inc_wp() to correctly transition zones to the full condition.
>>
>> Fixes: 0d1cf9378bd4 ("scsi: scsi_debug: Add ZBC zone commands")
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>> Changes from v1:
>> * Simplify the patch to not modify the zbc_finish_zone() function and
>>    not use the CLOSED zone condition as an intermediate state in
>>    zbc_set_zone_full(). Cleanups to remove the use of the closed
>>    condition as an intermediate state will be sent later.
>>
>>   drivers/scsi/scsi_debug.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
