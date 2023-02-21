Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B669E26B
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Feb 2023 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjBUOfu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 Feb 2023 09:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBUOft (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 Feb 2023 09:35:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337C26587
        for <linux-scsi@vger.kernel.org>; Tue, 21 Feb 2023 06:35:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF2CA68AFE; Tue, 21 Feb 2023 15:35:45 +0100 (CET)
Date:   Tue, 21 Feb 2023 15:35:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Fengnan Chang <changfengnan@bytedance.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: remove unused sd_cdb_cache
Message-ID: <20230221143545.GA30950@lst.de>
References: <20230220130530.62854-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220130530.62854-1-changfengnan@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
