Return-Path: <linux-scsi+bounces-2083-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603EA8447E1
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jan 2024 20:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D76E28A754
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jan 2024 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7BE3770C;
	Wed, 31 Jan 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC1frJoH"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4138DC8
	for <linux-scsi@vger.kernel.org>; Wed, 31 Jan 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728678; cv=none; b=bffph9jWdtXI0VIf+f9pnST0QjA8ZhPmYAZ+M5WPS05jBgGP0RxxQjDaqbKjxq4ucRw3ebZ08/0iNbO3ZFKrzeRJwmodO/1biDeDCiVpBKcu0aptCmceRqtmx9PQnkAs4JWqqTYwLMCcwPPhGtso7ute3EjhUgqqW4xUN/4D/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728678; c=relaxed/simple;
	bh=MUgnv5FqcUoe5DskRTyALhWieNzpekHbDDqXbALApN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSkmXmwqeNMUs4YmWaLhQoPGbUxtoQDXgv9ZeS4fWGj60egN+s7baNCEeNgwhcjGdgs6OFFfKZywR6++ggEpfJU+1KE0ugw6rRJ7CTQOnQG1qBYnRiHSNLToofbrQgKaZfEGYouPq79gOsZaklQ8jjOMuWDzG/3IgCqZ2egCUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BC1frJoH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706728675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F2HLLHWA6yNSaZ0qN3yDV0fsRl3D49AgWKDEnKxo7oA=;
	b=BC1frJoHd2Cgmlg4VA0iAwxdM9WweGVT+FO/KGOr7u7p+gc6b6vA0xVgAVcMyHDTxsJxra
	500esv0B0aejIKECVGwIDz5AEk80gigjaCbHLN7f/6ajHlAzeVY+lpEoZ/Bmh56OKED2es
	AYMet5pjxBwmptxdZEclPXo8hjCfX0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-3Gg7kGmzOlCJNUBUvDyK0w-1; Wed, 31 Jan 2024 14:17:53 -0500
X-MC-Unique: 3Gg7kGmzOlCJNUBUvDyK0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0694984FA84;
	Wed, 31 Jan 2024 19:17:53 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.rmtusor.csb (unknown [10.2.16.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 632D340C9444;
	Wed, 31 Jan 2024 19:17:51 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>
Cc: Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH 0/2] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
Date: Wed, 31 Jan 2024 11:17:30 -0800
Message-ID: <20240131191732.3247996-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

During bnx2i iSCSI testing we ran into page refcounting issues in the
uio mmaps exported from cnic to the iscsiuio process, and bisected back
to the removal of the __GFP_COMP flag from dma_alloc_coherent calls.

The cnic uio interface also has issues running with an iommu enabled,
which these changes correct.

In order to fix these drivers to be able to mmap dma coherent memory via
a uio device, introduce a new uio mmap type backed by dma_mmap_coherent.

While I understand some complaints about how these drivers have been
structured, I also don't like letting support bitrot when there's a
reasonable alternative to re-architecting an existing driver. I believe
this to be the most sane way to restore these drivers to functioning
properly.

There are two other uio drivers which are mmaping dma_alloc_coherent
memory as UIO_MEM_PHYS, uio_dmem_genirq and uio_pruss. While a
conversion to use dma_mmap_coherent might be more correct for these as
well, I have no way of testing them and assume that this just hasn't
been an issue for the platforms in question.

v4:
- re-introduce the dma_device member to uio_map,
  it needs to be passed to dma_mmap_coherent somehow
- drop patch 3 to focus only on the uio interface,
  explicit page alignment isn't needed
- re-add the v1 mail recipients,
  this isn't something to be handled through linux-scsi
v3 (Nilesh Javali <njavali@marvell.com>):
- fix warnings reported by kernel test robot
  and added base commit
v2 (Nilesh Javali <njavali@marvell.com>):
- expose only the dma_addr within uio and cnic.
- Cleanup newly added unions comprising virtual_addr
  and struct device

previous threads:
v1: https://lore.kernel.org/all/20230929170023.1020032-1-cleech@redhat.com/
attempt at an alternative change: https://lore.kernel.org/all/20231219055514.12324-1-njavali@marvell.com/
v2: https://lore.kernel.org/all/20240103091137.27142-1-njavali@marvell.com/
v3: https://lore.kernel.org/all/20240109121458.26475-1-njavali@marvell.com/

Chris Leech (2):
  uio: introduce UIO_MEM_DMA_COHERENT type
  cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT

 drivers/net/ethernet/broadcom/bnx2.c          |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 +
 drivers/net/ethernet/broadcom/cnic.c          | 15 +++++--
 drivers/net/ethernet/broadcom/cnic.h          |  1 +
 drivers/net/ethernet/broadcom/cnic_if.h       |  1 +
 drivers/uio/uio.c                             | 40 +++++++++++++++++++
 include/linux/uio_driver.h                    |  3 ++
 7 files changed, 60 insertions(+), 3 deletions(-)


base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.43.0


