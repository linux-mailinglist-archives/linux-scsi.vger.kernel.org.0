Return-Path: <linux-scsi+bounces-1178-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D01819719
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Dec 2023 04:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BEE1F26519
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Dec 2023 03:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E798F42;
	Wed, 20 Dec 2023 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G1qQ7DzF"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405E68BF6
	for <linux-scsi@vger.kernel.org>; Wed, 20 Dec 2023 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6cdf3e99621so882535b3a.1
        for <linux-scsi@vger.kernel.org>; Tue, 19 Dec 2023 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703042291; x=1703647091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=G1qQ7DzFK/ztH2sYXxjLo6olokvWbiUFdif+c3QnQc8WibAzRjm85/2S0sSl3sT3RK
         +aNIfv2ElHNkdkz2qawjtwwpXTf1xy+aTrl2XhVdulELGW3HHVqhNClMR3hvB/qJafg4
         MQ1kuoG9iqtA9gJpp0j4N8Obqa6TybDo8AIktrj7pjufShPm3EL2y/3EmCDjX65aYAXo
         /QYMEWyFHX6v0Lvv78ZKR16Vkq788y8rRo0znIby7soAIcEBmKKgkAEe++QepU2fd++7
         AaAmveI5cFyQoHqmempzrcXi6FdKZ4S7znhZREIx3XqaUOKm35RQoMzXf1rNdfBiJ/a/
         qlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042291; x=1703647091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=k6G+RBEMwF4xkbraApaky7FOyBdLtJ0H/7JEeq3dUhNwz2Eu3aIxG05SSIEGIzYwVY
         JINvQiVDBcLhelafuQykWhB1E6GnuOBO/adRpSGiBarw+sRmVCi7RxDg3nKN5L1WP4KA
         uaHAkmUBMvLXo9QQ1Gz+V7eNEo0XeZIi8Oc2ghMyT6hfMAXgzexhL3ii/1SZ4RgF0+jy
         jqjTjM7BBz0QrBEtnegtUBwt3WJ9+KT335uPmquIvXk9alXbqJdjTsR/QW3OEy8Kgo+d
         bK/odb02zzHzsLHynJ0IH9Ov3PWnJk1/wcY7EI+I7bPR4ekqTwqcyNO168ZRB8TAptmz
         RTNA==
X-Gm-Message-State: AOJu0YyQCJSVrKpxFgCZUUU0FWieemWLF7x8rDcLFB/r1NVXFkf4WUAW
	BPYyI8jYJVZq3ehR5zEXhoibMQ==
X-Google-Smtp-Source: AGHT+IGJy8KYnZyMHC+4fzSHET6hgmed+3GNH6+zA4QShlWQzZGtRyh4P66B+nvfNY4nmXMHOASd9w==
X-Received: by 2002:a05:6a20:3c8d:b0:18b:2020:8cd1 with SMTP id b13-20020a056a203c8d00b0018b20208cd1mr42952817pzj.3.1703042291622;
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78e46000000b006d088356541sm16958284pfr.104.2023.12.19.19.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, dm-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
Subject: Re: remove support for the host aware zoned model
Message-Id: <170304229020.683808.16849978519505449769.b4-ty@kernel.dk>
Date: Tue, 19 Dec 2023 20:18:10 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Sun, 17 Dec 2023 17:53:54 +0100, Christoph Hellwig wrote:
> hen zones were first added the SCSI and ATA specs, two different
> models were supported (in addition to the drive managed one that
> is invisible to the host):
> 
>  - host managed where non-conventional zones there is strict requirement
>    to write at the write pointer, or else an error is returned
>  - host aware where a write point is maintained if writes always happen
>    at it, otherwise it is left in an under-defined state and the
>    sequential write preferred zones behave like conventional zones
>    (probably very badly performing ones, though)
> 
> [...]

Applied, thanks!

[1/5] virtio_blk: cleanup zoned device probing
      commit: 77360cadaae562f437b3e98dc3af748d8d75bdc2
[2/5] virtio_blk: remove the broken zone revalidation support
      commit: a971ed8002110f211899279cd7295756d263b771
[3/5] block: remove support for the host aware zone model
      commit: 7437bb73f087e5f216f9c6603f5149d354e315af
[4/5] block: simplify disk_set_zoned
      commit: d73e93b4dfab10c80688b061c30048df05585c7e
[5/5] sd: only call disk_clear_zoned when needed
      commit: 5cc99b89785c55430a5674b32ad0d9e57a8ec251

Best regards,
-- 
Jens Axboe




