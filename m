Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1886BBD22
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Mar 2023 20:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjCOTWw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Mar 2023 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjCOTWs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Mar 2023 15:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129475CC1F
        for <linux-scsi@vger.kernel.org>; Wed, 15 Mar 2023 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678908126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bLdC3wHFT7oUZ2jPsmMgtk2F4YyIOWga1n5deAIvgCc=;
        b=GMo+coXWOGVNmUcmk5G9JZGagsgqpsQq+A7ubpK+AHYnaQzNfGn/M09i8bpvrpD4FSncsK
        dFVw11+C4K3n7nkJ6+11YI0SSsmpz1cY0emKzx4FbwMsqUdyseF6nynI5P8P/Jv4lkc5i+
        F6ANkwiesp2H3ibkXbpnLa+8Fzw41Dw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-IeopC1enPc-oAJsZDGCFrg-1; Wed, 15 Mar 2023 15:22:02 -0400
X-MC-Unique: IeopC1enPc-oAJsZDGCFrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDB69185A792;
        Wed, 15 Mar 2023 19:22:01 +0000 (UTC)
Received: from desnesn.remote.csb (ovpn-116-3.gru2.redhat.com [10.97.116.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C825240C6E67;
        Wed, 15 Mar 2023 19:21:58 +0000 (UTC)
From:   Desnes Nunes <desnesn@redhat.com>
To:     iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, linux-kernel@vger.kernel.org
Cc:     hch@lst.de, martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com, Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH 0/3] scsi: smartpqi: fix DMA overlapping mappings asymmetry
Date:   Wed, 15 Mar 2023 16:21:27 -0300
Message-Id: <20230315192130.970021-1-desnesn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In summary, this series fixes an overlapping mappings asymmetry on the
smartpqi driver due to a missing pqi_pci_unmap() call, while also adding
the cacheline on debug messages of dma-debug debugging functions.

Other minor non-functional updates are also provided.

Desnes Nunes (3):
  dma-debug: small dma_debug_entry's comment and variable name updates
  dma-debug: add cacheline to user/kernel space dump messages
  scsi: smartpqi: fix overlapping mappings asymmetry on DMA

 drivers/scsi/smartpqi/smartpqi_init.c |   2 +
 kernel/dma/debug.c                    | 133 ++++++++++++++------------
 2 files changed, 72 insertions(+), 63 deletions(-)

-- 
2.39.1

