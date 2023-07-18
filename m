Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154A757483
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jul 2023 08:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGRGnV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jul 2023 02:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRGnU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jul 2023 02:43:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47212D
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jul 2023 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689662599; x=1721198599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JYJNcEdLESOor3MiOXli2Vok9TvRCEdmBcKXLx2aapI=;
  b=lVQ37GE1xnuXMIttuy9UWBze9JUzxJhe0WF6wyfkmX/grv/+Nw39m7O4
   cmJXMXuW/Mi0mHF13W7b2X1+xS/QzlZ6RqrLp2yD/tOTrffItieJwlL4C
   6w2x+9+ByEKngLn+iiEqVDCSfZ5AGVb2olmqGJhQ1+I6otBMUM8e3y/VO
   DpR5qeSx5q+EXaEcHCBa1v9HA6MRzoSWTvrTUrAOJHgOnDgbepzLZ0Z3a
   zAuJUJ2p8YSDyHE1noqHsgaZfTzbr9NW1msJnFtZ17fAvVpf42V2B5Ef3
   XcJXPUschjySz9tsuNIgtcEKAj2bhHMSgDE7Zn71X6T21iOyqvPAxKPMc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="363589304"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="363589304"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="847593088"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="847593088"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.138])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:43:12 -0700
Message-ID: <46838112-007a-0245-8026-59e35b6e2415@intel.com>
Date:   Tue, 18 Jul 2023 09:43:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] scsi: ufs: Remove HPB support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        ChanWoo Lee <cw9316.lee@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Markus Fuchs <mklntf@gmail.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>
References: <20230717193827.2001174-1-bvanassche@acm.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230717193827.2001174-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 17/07/23 22:36, Bart Van Assche wrote:
> Interest among UFS users in HPB has reduced significantly.

Can you say more about why, or give some background?

