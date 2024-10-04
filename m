Return-Path: <linux-scsi+bounces-8689-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AAF9912ED
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Oct 2024 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B011C22793
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Oct 2024 23:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44E155CB0;
	Fri,  4 Oct 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTv44E1A"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14476155336;
	Fri,  4 Oct 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084037; cv=none; b=Y8ViPQp+qsIgSGuyD8PbvsW5WhZ+xDTRgD2Aa9cT1wMX8I48eaeg7qLpFYmZWKMZMk/AJbnQ3gFQt5nVX4woL9S8V3FWo54kmylP74DTcEdvIfIDyJEyFkGTCeQcT2SaqT5zoyjsuYfw0irJISFUUhSNdqE8Z41EJQopPjXl2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084037; c=relaxed/simple;
	bh=tUSjkrEkMrf5s8z6akQfZLUkZn95MYz8cS63A/wVL0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A31gtJygddX8mH/rFNyCtmd0EUq8PLdEjloe2yRTRh97dkbo7WJg6korTZK3JXTHeJ9oTywSBqT5DgwLorzwr4IFLe1E01077Gyg8gHXZitFeBcXF24PIaJZW/9hnkQCTzJV+aBUsfCpKzrSlKzpWX5vxrvvQ1o1dFwfVzAC1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTv44E1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FEDC4CED0;
	Fri,  4 Oct 2024 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084036;
	bh=tUSjkrEkMrf5s8z6akQfZLUkZn95MYz8cS63A/wVL0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hTv44E1ApOhjo14ODIMYqzRrpN4wyAY2id5SJpD4nZhfGrI5Z1VTGod+jC3yYAWOf
	 FkDYSI76ve0LSMKBuDbCnfbGE+BmG+zZeH99ULB8z0lGyCJ9D3kQVyGETo2/y8QWGa
	 DveDy6J2XV/wf37fsljxF6Fhh5T36/rch94p1BuztBKsW1Qua+LFXNEXj3yA0zaOdv
	 WI7RSVaDFpTXXr6+cp2oQZfrJRzX3ztM2qpB2dknyncc+qqkGEsru3DyQN89omGhwv
	 0QRnHhmXbiwm3rbd3XEneypjY+K9n2Zq7b/mo6bJ4dD30u0IzTCXT4nsDzOLlHkyq6
	 RoAGsUAKYdJrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCD39F76FF;
	Fri,  4 Oct 2024 23:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808404024.2772330.2975585273609596688.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:20:40 +0000
References: <20241003035333.49261-1-mhklinux@outlook.com>
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>
To: Michael Kelley <mhkelley58@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 iommu@lists.linux.dev, netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Oct 2024 20:53:28 -0700 you wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Code specific to Hyper-V guests currently assumes the cpu_possible_mask
> is "dense" -- i.e., all bit positions 0 thru (nr_cpu_ids - 1) are set,
> with no "holes". Therefore, num_possible_cpus() is assumed to be equal
> to nr_cpu_ids.
> 
> [...]

Here is the summary with links:
  - [1/5] x86/hyperv: Don't assume cpu_possible_mask is dense
    (no matching commit)
  - [2/5] Drivers: hv: Don't assume cpu_possible_mask is dense
    (no matching commit)
  - [3/5] iommu/hyper-v: Don't assume cpu_possible_mask is dense
    (no matching commit)
  - [4/5] scsi: storvsc: Don't assume cpu_possible_mask is dense
    (no matching commit)
  - [net-next,5/5] hv_netvsc: Don't assume cpu_possible_mask is dense
    https://git.kernel.org/netdev/net-next/c/c86ab60b92d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



