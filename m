Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0436A77F4F0
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Aug 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350213AbjHQLV1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Aug 2023 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350223AbjHQLVH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Aug 2023 07:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA4B30C7;
        Thu, 17 Aug 2023 04:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333CC60B04;
        Thu, 17 Aug 2023 11:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1D5C433C8;
        Thu, 17 Aug 2023 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692271262;
        bh=F0ufM8zewZlPFRi2IkUcbSfw6Wop6Ix6qWQBsiesSuI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OIoNLLEA0XMLCv9sorXatsGh4nmjRJrnntFhOZfO/4C+0eC3SuXdVXN/KgCyNKqg6
         whuX0aUY9aeYeKOI1XsFlkXsV31JM0+h90+fCRD+oLMYWhQtJB2ZkOerwrg94lENUm
         WgVN6FGSXxshNP9zJqbFRvR0pe3RcnKCUNhbNjg0dtNpauUH70AMrhIfWWQ4E84Zee
         cIQKUsgGZSHBnmn9RT1a+4lZdBS/KAMyOwv6q9cudQ6bb2D1YXjy4quKZ8rQ0ZjK9J
         ySvITOUiiRx10muOeoFbQM0SdtMNs76mPECdw/dHUmfAS2BiIqLKAL1417hHl/cTOD
         OB6V4GPmp1bwQ==
Message-ID: <19beadb4-8082-7570-0460-27149e5a22f7@kernel.org>
Date:   Thu, 17 Aug 2023 20:21:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 07/17] scsi: core: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230816195447.3703954-1-bvanassche@acm.org>
 <20230816195447.3703954-8-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230816195447.3703954-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/17/23 04:53, Bart Van Assche wrote:
> If zoned writes (REQ_OP_WRITE) for a sequential write required zone have
> a starting LBA that differs from the write pointer, e.g. because zoned
> writes have been reordered, then the storage device will respond with an
> UNALIGNED WRITE COMMAND error. Send commands that failed with an
> unaligned write error to the SCSI error handler if zone write locking is
> disabled. The SCSI error handler will sort SCSI commands per LBA before
> resubmitting these.
> 
> If zone write locking is disabled, increase the number of retries for
> write commands sent to a sequential zone to the maximum number of
> outstanding commands because in the worst case the number of times
> reordered zoned writes have to be retried is (number of outstanding
> writes per sequential zone) - 1.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

