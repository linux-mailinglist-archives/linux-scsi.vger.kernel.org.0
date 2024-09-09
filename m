Return-Path: <linux-scsi+bounces-8089-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C559716C6
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Sep 2024 13:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E652E1F23C3B
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Sep 2024 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2391B6537;
	Mon,  9 Sep 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKjvFpH9"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673501B5EC1;
	Mon,  9 Sep 2024 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881068; cv=none; b=qT1EmpALMXIKgqIZfQHQ0doaOMW9uQafSivh77r48WMR4ilH3VUWB3tb5eG3hxqxpjrixxwYBfUB0lUbbd+5/uoGw7FpMFyzI5gWbUCmPOSRcjmPvXyo/W6hedG9Ddt5RMCqN3ANUUMU8b2f9gOK11L8fVw+j+57ruKdmcNgN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881068; c=relaxed/simple;
	bh=NOXjUpcY8hYNWLF1WhCDUlTQ0y37JVq1LQvC9dM8LHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8HZrjdyJlceK4KOe6erMNXYh8uQYjmtsZkWmGjW9PZCJb0bp/lFjAEU0K3FbWNyQlRq4qh1gn+fssYsvl/jW1x0/Gm8u13J/qWpdbTlmv5v0YqWyxI8XIxhSC0QGvogr3imiapOw5I/4y2JXxgpx08DDa0wGzxBtqqAg+29RnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKjvFpH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDF5C4CEC5;
	Mon,  9 Sep 2024 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725881067;
	bh=NOXjUpcY8hYNWLF1WhCDUlTQ0y37JVq1LQvC9dM8LHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VKjvFpH9PHRu582HpZ3MNhR/HiW1lNHcyeG+egqQKhQRhFwMFZ7mkzQ3m0pZyMJtN
	 v0WfQMAk4iHgw3ZgvIEAti7mIQtEsnSBbBC8EUthPwf5rWX0hmNlTm+rCD8zkZ+9dg
	 +UpcEvfFvJ3UgYZYFiR1bTD7D7AUx9syc8LN/FP9I3pgfCd+/B5ALbOZwqCfPSXKnW
	 4Ckuh3gV6uidK+H62wvAudqZsFZ2bENjjyvXkbNmfSYw2+wrR6QDpLk80wKejxCiSH
	 ygDsfHi/Wr/xKSLmyQvsYyz/CJgue4yuOTXev37XuvieL/ZgfP5kdPXGeze8EUJ0jm
	 ZVJY2fchySb7Q==
Message-ID: <a79e30d7-1c11-4dc1-bf1a-4a4577b30b0a@kernel.org>
Date: Mon, 9 Sep 2024 13:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/17] firmware: qcom: scm: add calls for creating,
 preparing and importing keys
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-7-d59e61bc0cb4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240906-wrapped-keys-v6-7-d59e61bc0cb4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.09.2024 8:07 PM, Bartosz Golaszewski wrote:
> From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> 
> Storage encryption has two IOCTLs for creating, importing and preparing
> keys for encryption. For wrapped keys, these IOCTLs need to interface
> with Qualcomm's Trustzone. Add the following keys:
> 
> generate_key:
>   This is used to generate and return a longterm wrapped key. Trustzone
>   achieves this by generating a key and then wrapping it using the
>   Hawrdware Key Manager (HWKM), returning a wrapped keyblob.
> 
> import_key:
>   The functionality is similar to generate, but here: a raw key is
>   imported into the HWKM and a longterm wrapped keyblob is returned.
> 
> prepare_key:
>   The longterm wrapped key from the import or generate calls is made
>   further secure by rewrapping it with a per-boot, ephemeral wrapped key
>   before installing it in the kernel for programming into ICE.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> [Bartosz:
>   improve kerneldocs,
>   fix hex values coding style,
>   rewrite commit message]
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

same question as patch 6, lgtm otherwise

Konrad

