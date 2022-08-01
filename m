Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE27587046
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Aug 2022 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiHASOa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Aug 2022 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHASO2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 1 Aug 2022 14:14:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332419C10
        for <linux-scsi@vger.kernel.org>; Mon,  1 Aug 2022 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gtc2WIcu48QmHOng6TWwwO8Dfm8/xcflk0wo50jOCxw=; b=olr1FpXOLF58jXs1E0Cv6QnhXM
        RnB7e17wJ0QmLquPTXlKV1qxvKT3uzLUTpl5alninhL7EGlxDTZzTO3Bp3f31kmWOU3MXLdg/C9oP
        4JVyHNDc3H7FFbuDv+Nmbd4rbb17tZys5usvrA6OYNDMX/v7zKf3w2kXnseiAsYuYOV+01TBpE3PN
        97wBFclNI1WwrOsjmmO8ePT4PhO7TYJLMjvizKiVF0HHp54zVBxyGWNW8rUN6+bcrGWOdF7aTxHN0
        K6jgvjXSeuFwtw1m/nw7FmYpci7q0BjEo3/uWeKDS/xMqCurR/ekbg6oOt79ljP2LP7KNKl+2WqPF
        c3+cqvbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIZvl-008kvA-W2; Mon, 01 Aug 2022 18:14:18 +0000
Date:   Mon, 1 Aug 2022 11:14:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, powen.kao@mediatek.com,
        qilin.tan@mediatek.com, lin.gui@mediatek.com
Subject: Re: [PATCH v1 0/2] ufs: allow vendor disable wb toggle in clock
 scaling
Message-ID: <YugX+ZlD6cHC0+Kz@infradead.org>
References: <20220728071637.22364-1-peter.wang@mediatek.com>
 <YugT7jfkMGGvH7hO@infradead.org>
 <ffa00837-5e3f-24fa-ac2c-7d4a505c848b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa00837-5e3f-24fa-ac2c-7d4a505c848b@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Aug 01, 2022 at 11:12:17AM -0700, Bart Van Assche wrote:
> Agreed that the description should become more clear. I think Peter wanted
> to refer to the "vendor driver" where he wrote "vendor".

vendor driver makes just as little sense.  hardware interfaces do not
map to vendors in any sensible way.
