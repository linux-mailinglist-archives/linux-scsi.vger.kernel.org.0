Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C14EA7BC
	for <lists+linux-scsi@lfdr.de>; Tue, 29 Mar 2022 08:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiC2GRZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Mar 2022 02:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiC2GRY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 29 Mar 2022 02:17:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804D247C33
        for <linux-scsi@vger.kernel.org>; Mon, 28 Mar 2022 23:15:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 479D168AFE; Tue, 29 Mar 2022 08:15:39 +0200 (CEST)
Date:   Tue, 29 Mar 2022 08:15:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     martin.petersen@oracle.com, hch@lst.de, linux@roeck-us.net,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: core: sysfs: remove comments that conflict with
 the actual logic
Message-ID: <20220329061538.GA19640@lst.de>
References: <20220329021251.123805-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329021251.123805-1-liu.yun@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
